
class MyClass {
  dynamic _count;
  get count => _count;
  setCount(newCount){
    _count = newCount;
  }
}

void main(){
  dynamic t = MyClass();
  MyClass().setCount(0);
  print(MyClass().count);
  }