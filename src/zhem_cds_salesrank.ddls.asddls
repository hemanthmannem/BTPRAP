@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'sales consumption rank'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zhem_cds_salesrank
  as select from ZHEM_TBF_SALES(p_clnt:$session.client) as ranked
    inner join   zhem_tbl_bpa                           as bpa   on ranked.company_name = bpa.company_name
    inner join   zhem_tbl_region                        as regio on bpa.region = regio.region
{
  key ranked.company_name,
  @Semantics.amount.currencyCode: 'currency_code'
  ranked.total_sales,
  ranked.currency_code,
  ranked.customer_rank,
  regio.regionname
}
