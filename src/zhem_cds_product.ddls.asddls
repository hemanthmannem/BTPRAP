@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'product'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zhem_cds_product as select from zhem_tbl_product
{
    key product_id as ProductId,
    name as Name,
    category as Category,
    @Semantics.amount.currencyCode: 'currency'
    price as Price,
    currency as currency,
    discount as Discount
}
