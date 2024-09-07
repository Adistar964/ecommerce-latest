
class MyClass {
  dynamic count;
  setCount(newCount){
    count = newCount;
  }
}

void main(){
  dynamic t = MyClass();
  t.setCount(0);
  print(t.count);
  }