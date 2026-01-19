import 'package:formz/formz.dart';

class Person {
  Person.named(this.name);

  String name;
}

class Worker extends Person {
  // 如果前面调用了super的参数，那么后面就不需要了
  Worker.named(super.name) : super.named();
}

void main() {
  
}