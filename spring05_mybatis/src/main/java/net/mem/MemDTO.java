package net.mem;

public class MemDTO {
	
	private int num;
	private String name;
	private int age;
	
	public MemDTO() {}
	
	public MemDTO(int age) {
		this.age = age;
	}	
	
	public MemDTO(int num, int age) {
		this.num = num;
		this.age = age;
	}
	
	public MemDTO(String name, int age) {
		this.name = name;
		this.age = age;
	}

	public MemDTO(int num, String name, int age) {
		this.num = num;
		this.name = name;
		this.age = age;
	}

	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	
	@Override
	public String toString() {
		return "MemDTO [num=" + num + ", name=" + name + ", age=" + age + "]";
	}
	
} // class end
