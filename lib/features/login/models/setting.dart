import 'package:equatable/equatable.dart';

class Setting extends Equatable{
  const Setting({ this.copyrightText = '',  this.bgImgUrl = '' });

  final String copyrightText;
  final String bgImgUrl;



  @override
  List<Object?> get props => [copyrightText, bgImgUrl];
}