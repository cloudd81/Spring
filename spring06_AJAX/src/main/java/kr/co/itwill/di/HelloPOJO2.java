package kr.co.itwill.di;

public class HelloPOJO2 {

	public static void main(String[] args) {
		
		IHello hello = null;
		
		hello = new MessageKO2(); //다형성
		hello.sayHello("손흥민");
		
		hello = new MessageEN2();
		hello.sayHello("John");

	}//main() end
}//class end