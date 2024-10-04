@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'sales Analystics consumption'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Analytics.query: true
define view entity zhem_c_cds_sales as select from zhem_i_cds_salescube
{
  @AnalyticsDetails.query.axis: #ROWS
    key _BusinessPartner.CompanyName,
    @AnalyticsDetails.query.axis: #ROWS
    key _BusinessPartner.countryname,
    @Aggregation.default: #SUM
    @Semantics.amount.currencyCode: 'CurrencyCode'
    @AnalyticsDetails.query.axis: #COLUMNS
    GrossAmount,
    @AnalyticsDetails.query.axis: #ROWS
    @Consumption.filter.selectionType: #SINGLE
    CurrencyCode,
    @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
    @AnalyticsDetails.query.axis: #COLUMNS
    quan,
    @AnalyticsDetails.query.axis: #ROWS
    UnitOfMeasure
 }
