@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'sample'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZHEM_CDS_bpa as select from zhem_tbl_bpa 
association[1] to I_Country as _country on
 $projection.Countrycode = _country.Country
{
    key bp_id as BpId,
    bp_role as BpRole,
    company_name as CompanyName,
    street as Street,
    country as Countrycode,
    region as Region,
    city as City,
    _country._Text[Language= $session.system_language].CountryName as countryname
    }
