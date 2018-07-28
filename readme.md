# 将迷宫渲染为字符串题解说明
### 运行方式
- 1.手动输入测试的则直接运行main方法。
- 2.多组测试案例循环调用processNet方法。
### 代码


	import java.util.ArrayList;
	import java.util.Iterator;
	import java.util.List;
	import java.util.Scanner;

	public class thoughtworks {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		String line1 = sc.nextLine();
		String line2 = sc.nextLine();
		processNet(line1,line2);
	}
	//line1表示测试案例的第一行，line2表示测试案例的第二行
	private static void processNet(String line1,String line2) {
		
		String[] shape = line1.split(" ");
		if(shape.length!=2) {
			System.out.println("Invalid numberformat");
			return ;
		}
		int n = Integer.valueOf(shape[0]);
		int m = Integer.valueOf(shape[1]);
		int row = n*2+1;
		int col = m*2+1;
		String [][] net = new String [row][col];
		for(int i=0;i<row;i++) {
			for(int j=0;j<col;j++) {
				if(i%2==1 && j%2==1) {
					net[i][j] ="[R]";
				}else {
					net[i][j]="[W]";
				}
				
			}
		}
		
		String[] arrs = line2.split(";");
		if(arrs.length<1) {
			System.out.println("Invalid number format");
			return ;
		}
		List<String> list = new ArrayList<String>();
		for(int i=0;i<arrs.length;i++) {
			int flag = helper(net,arrs[i],row,col);
			if(flag ==-1)
				return ;
			else if(flag==0){
				list.add(arrs[i]);
			}
		}
		int last = 0;
		while(list.size() != last && list.size()>0) {
			last = list.size();
			Iterator<String> it = list.iterator();
			while(it.hasNext()) {
				String s = it.next();
				int f = helper(net,s,row,col);
				if(f==1) {
					it.remove();
				}
			}
		}
		
		if(list.size()==0) {
			//StringBuilder sb=new StringBuilder();
			String s ="";
			for(int i=0;i<net.length;i++) {
				for(int j=0;j<net[0].length;j++) {
					s+=net[i][j]+" ";
				}				
				System.out.println(s.trim());
				s="";
			}
		}else {
			System.out.println("Maze format error.");
			return ;
		}
	}
	/*
	 * 1，表示连通
	 * 0，表示是相邻节点，暂时不能连通（可能所给的一个或者两个节点都是墙）
	 * -1，表示有错误，错误原因已经打印
	 */
	private static int  helper(String [][] net,String s,int row,int col) {
		String[] nodes = s.split(" ");
		if(nodes.length==2) {
			String[] pair1 = nodes[0].split(",");
			String[] pair2 = nodes[1].split(",");
			Integer x1=-1; 
			Integer x2=-1; 
			Integer y1=-1; 
			Integer y2=-1; 
			if(pair1.length==2 && pair2.length==2) {
				try {
					x1= Integer.valueOf(pair1[0])*2+1;
					y1 = Integer.valueOf(pair1[1])*2+1;
					x2= Integer.valueOf(pair2[0])*2+1;
					y2 = Integer.valueOf(pair2[1])*2+1;
				} catch (NumberFormatException e) {
					System.out.println("Invalid number format.");
					return -1;
				}
				if(!validateNum(x1,x2,y1,y2,-1, row,col)) {
					System.out.println("Number out of range.");
					return -1;
				}
				if(Math.abs(x1-x2)+Math.abs(y1-y2)>2)
				{
					System.out.println("Maze format error.");
					return -1;
				}
				if(Math.abs(x1-x2)+Math.abs(y1-y2)==0) {
					//两个点是同一个点，自己是连通的，不需要判断了
					return 1;
				}
				//两个节点是相邻的，判断是否能连接
				if(net[x1][y1].equals("[R]") &&  net[x2][y2].equals("[R]")) {
				{	
					net[(x1+x2)/2][(y1+y2)/2] = "[R]";
					return 1;
				}
				}else {
					
					return 0;
				}
				
				
			}else {
				System.out.println("Incorrect command format​.");
				return -1;
			}
			
		}else {
			System.out.println("Incorrect command format​.");
			return -1;			
		}
	}
	//验证一组输入是否合格（只验证范围）
	private static  boolean validateNum(int x1,int x2,int y1,int y2,int min,int row,int col) {
		if(x1<row && x1>min && x2<row && x2>min && y1<col && y1>min && y2<col && y2>min ) {
			return true;
		}
		return false;
	}
	
	}


