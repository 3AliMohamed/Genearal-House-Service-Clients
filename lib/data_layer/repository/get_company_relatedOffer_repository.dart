class GetCompanyRepository{
  static final GetCompanyRepository _singleton = GetCompanyRepository._internal();

  factory GetCompanyRepository() {
    return _singleton;
  }
  GetCompanyRepository._internal();



}