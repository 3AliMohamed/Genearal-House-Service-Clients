import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_house_service_clients/business_logic_layer/cubit/get_company_relatedOffer/states.dart';
import 'package:general_house_service_clients/data_layer/repository/get_company_relatedOffer_repository.dart';

import '../../../data_layer/models/responses/company_response.dart';
import '../../../presentation_layer/screens/products_screen.dart';

class GetCompanyCubit extends Cubit<GetCompanyState>
{
  GetCompanyCubit() : super(GetCompanyInitialState());

 static GetCompanyCubit get(context)=> BlocProvider.of(context);


  void getCompany(int id, context)async{
    Data company= await GetCompanyRepository.getCompany(id);

    int categoryId=company.categories![0].id!; // we take by default the first category as chsosen category
    dynamic categories= company.categories;
    Map<String,dynamic> companyMap=company.toJson();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsScreen(categoryId: categoryId,
      companyId:id ,categoriesProduct: categories,company: companyMap,) ));
  }

  }

