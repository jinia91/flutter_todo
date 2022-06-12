# todo_app

## 플러터는 모든것이 widget

![image](https://user-images.githubusercontent.com/85499582/173232028-50c0b903-e611-4ef7-a219-9c2745096e74.png)


- 선언적 UI(declarative style of UI)
- UI에 대한 설명은 Widget이라고 할 수 있고 Widget을 통해 Flutter 프레임워크가 자동으로 UI객체를 생성과 유지를 해준다. 만약 변경사항이 일어나면 Widget을 변경시키고 UI 객체를 다시 재생성한다.

### Stateless Widget

- 변하지 않는 위젯
- 리액트로치면 훅같은게 없어서 관찰이 일어나지않음
- Static 한 위젯

### StateFul Widget

- 상태정보를 가지고 있는 위젯
- State 라는 서브클래스를 통해 상태정보를 저장하고, setState() 함수로 상태값을 변경
- 리액트 useState개념과 동일한듯

#### LifeCycle

1. createState()

State 객체가 최초로 생성되는 시점 BuildContext가 State에 할당된다.

2. mounted == true

BuildContext가 State에 할당됐는지 확인한다.
할당됐으면 State가 마운트된 것으로 보고 true를 반환한다.

3. initState()
 
이 Lifecycle때 Widget 혹은 BuildContext 초기화하면 된다.

4. didChangeDependencies()

상속한 Widget이 업데이트될때 호출된다.

5. build()

Widget을 리턴하며 이를 바탕으로 Framework가 UI를 그린다.

6. didUpdateWidget()

Widget에 변경이 있을때 호출된다.

7. setState()

위에서도 봤던 함수로 프레임워크에 변경사항을 알린다.

8. deactivatie()

State 객체가 삭제된다.
삭제되는 애니메이션 프레임이 끝나기 전에 재사용이 가능하다.

9. dispose()

State 객체가 트리에서 영구적으로 삭제된다.

10. mounted == false

State의 마운트가 완전히 해제됐다.

[state doc](https://api.flutter.dev/flutter/widgets/State-class.html)


## 화면전환 (Navigator, Route)

- Navigator : push, pop을 통해 스택구조로 화면을 쌓고 빼는 전환
- Route : 라우팅으로 화면을 렌더링하는 경로 자체를 전환

## Provider 라이브러리를 통해 MVVM 아키텍처 구성하기

- 전역 상태관리해주는 Provider 라이브러리

>  provider: ^5.0.0


### e.g.

class TodoListVM with ChangeNotifier{
  late List<TodoViewModel> todos;

  void fetch(){
    final todoModels = [
      Todo("Dummy", "DummyMemo", "DummyCategory", Colors.red.value, false,
          2022612),
      Todo("Dummy2", "DummyMemo", "DummyCategory", Colors.blue.value, true,
          2022612),
      Todo("Dummy3", "DummyMemo", "DummyCategory", Colors.green.value, false,
          2022612),
      Todo("Dummy4", "DummyMemo", "DummyCategory", Colors.amber.value, true,
          2022612)
    ];
    todos = todoModels.map((todo) => TodoViewModel(todo)).toList();
    notifyListeners();
  }

  void add(Todo todo){
    var newTodoViewModel = TodoViewModel(todo);
    todos.add(newTodoViewModel);
    notifyListeners();
  }
}

class TodoViewModel{
  final Todo todo;

  TodoViewModel(this.todo);
}
 
이런식으로 뷰모델만들고
 
- 뷰가 구독하게한다음, 뷰모델에서 특정 행위시 notifyListeners() 를 통해 pub해서 뷰를 재랜더링하도록 하면 될듯?
 
