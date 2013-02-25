delete ucs_asset ;
delete ucs_order_metrics ;
delete ucs_product ;
delete ucs_order ;

-- delivery item
delete dst_delivery_transaction ;
delete dst_delivery_item ;
delete dst_delivery_items_group ;

-- RSK
delete rsk_request ;
delete rsk_batch_risk ;

-- nettoyer les SI
delete DST_SYNC_INSTR_COUNTRY_R ;
delete DST_SYNC_INSTRUCTION_LOG ;
delete DST_RIGHT_PKG_DIRECTIVE ;
delete DST_PROVISIONING_DIRECTIVE ;
delete DST_PACKAGING_DIRECTIVE ;
delete DST_DELIVERY_PROD_ARTIFACT ;
delete DST_SYNC_INSTR_PARTNER_ORDER ;
-- ajout manu
  --delete dst_order_instruction ;
  delete dst_si_price_data ;
  delete dst_differential_info ;
  delete dst_catalog_item_diff ;
-- fin ajout
delete dst_sync_instruction ;


-- nettoyer les batchs
delete rkg_ranking_request ;
delete rkg_batch_weighting ;

delete dst_catalog_item_log ;
delete dst_catalog_item_country_r ;
delete dst_catalog_item_history ;
delete dst_command_catalog_item ;

delete dst_catalog_item ;


-- order
delete dst_partner_order ;
delete dst_order_config_set ;
-- TODO dst_product_list, dst_selection, dst_daily_planning
delete dst_selected_product ;
delete dst_order ;
delete dst_capacity_lease ;
delete dst_batch_action ;
delete dst_batch ;

commit;