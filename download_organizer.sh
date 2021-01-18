#!/usr/bin/env bash

export LABEL="/media/share/sahel_label"

move_inventory_files () {
	find ~/Downloads -regex ".*SSinv.*\.pdf" -exec mv {} $LABEL/admin/statements/secretly/inventory \;
	find ~/Downloads -regex ".*SSwhfees.*\.xlsx" -exec mv {} $LABEL/admin/statements/secretly/fees \;
}

move_statement_files () {

	# Secretly Dist files
	find ~/Downloads -regex .*SS.*physpd.csv* -exec mv {} $LABEL/admin/statements/secretly/phy \;
	find ~/Downloads -regex .*SS.*digpd.csv* -exec mv {} $LABEL/admin/statements/secretly/dig \;
	find ~/Downloads -regex .*SS.*qb.xlsx* -exec mv {} $LABEL/admin/statements/secretly/ \;
	find ~/Downloads -regex .*SS.*t.*.xlsx* -exec mv {} $LABEL/admin/statements/secretly/ \;
	find ~/Downloads -regex .*SSwhfees.*.xlsx* -exec mv {} $LABEL/admin/statements/secretly/fees \;
	find ~/Downloads -regex .*SS.*manualreport.csv* -exec mv {} $LABEL/admin/statements/secretly/phy \;

	# Bandcamp files
	find ~/Downloads -regex .*_bandcamp_raw_data_Sahel-Sounds.csv -exec mv {} $LABEL/admin/statements/bandcamp/ \;

	# Shopify
	find ~/Downloads -regex .*sales_[0-9][0-9][0-9][0-9]-.* -exec mv {} $LABEL/admin/statements/shopify/ \;

	# SDS (Ingrooves)
	find ~/Downloads -regex .*Sahel_Sounds_202[0-9][0-9][0-9]_DSR.*.csv -exec mv {} $LABEL/admin/statements/sds/ \;

}


move_vimeo_statements () {
	find ~/Downloads -regex .*vimeo_sales_and_payments.*.csv -exec mv {} $LABEL/admin/statements/vimeo \;

}

clean_up () {
	find ~/Downloads -regex .*__MACOSX -exec rm -rf {} \;
}

move_inventory_files
move_statement_files
move_vimeo_statements
clean_up

