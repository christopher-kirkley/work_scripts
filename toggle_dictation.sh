#!/bin/bash

# toggle_dictation.sh
# Whisper dictation via Groq API
# Requires: sox, curl, xdotool
# Install: pip install --break-system-packages groq
# Set GROQ_API_KEY in ~/.bashrc or ~/.profile

LOG_FILE="/tmp/dictation.log"
source "$HOME/.env" 2>/dev/null
AUDIO_FILE="/tmp/dictation_audio.wav"
PID_FILE="/tmp/dictation.pid"

log() {
    echo "[$(date '+%H:%M:%S')] $1" >> "$LOG_FILE"
}

# Check key is set
if [ -z "$GROQ_API_KEY" ]; then
    log "ERROR: GROQ_API_KEY not set"
    exit 1
fi

if [ -f "$PID_FILE" ]; then
    # --- STOP recording ---
    SOX_PID=$(cat "$PID_FILE")
    log "Stopping recording (PID: $SOX_PID)"
    dunstify -u low -t 3000 -r 9999 "Dictation" "Processing..."
    kill "$SOX_PID" 2>/dev/null
    sleep 0.5
    rm "$PID_FILE"

    if [ ! -f "$AUDIO_FILE" ]; then
        log "ERROR: Audio file not found at $AUDIO_FILE"
        exit 1
    fi
    log "Audio file size: $(wc -c < "$AUDIO_FILE") bytes"

    # Send to Groq
    log "Sending to Groq API..."
    HTTP_CODE=$(curl -s -o /tmp/dictation_response.txt -w "%{http_code}" \
        https://api.groq.com/openai/v1/audio/transcriptions \
        -H "Authorization: Bearer $GROQ_API_KEY" \
        -F model="whisper-large-v3" \
        -F file="@$AUDIO_FILE" \
        -F response_format="text")
    RESPONSE=$(cat /tmp/dictation_response.txt)

    log "HTTP status: $HTTP_CODE"

    if [ "$HTTP_CODE" != "200" ]; then
        log "ERROR: API returned $HTTP_CODE: $RESPONSE"
        rm -f /tmp/dictation_response.txt
        exit 1
    fi

    if [ -z "$RESPONSE" ]; then
        log "ERROR: No transcription returned"
        exit 1
    fi

    log "Transcription: $RESPONSE"

    # Type into focused window
    xdotool type --clearmodifiers --delay 0 "$RESPONSE"
    log "Typed into window"
    rm -f "$AUDIO_FILE"

else
    # --- START recording ---
    log "Starting recording..."
    dunstify -u low -t 0 -r 9999 "Dictation" "Recording..."
    MAX_DURATION=120
    (sox -t alsa default -r 16000 -c 1 -b 16 "$AUDIO_FILE" trim 0 $MAX_DURATION; rm -f "$PID_FILE"; dunstify -u low -t 3000 -r 9999 "Dictation" "Recording timed out") &
    echo $! > "$PID_FILE"
    log "Recording started (PID: $!)"
fi
