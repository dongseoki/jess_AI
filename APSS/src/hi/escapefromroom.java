package hi;

import java.util.Scanner;

public class escapefromroom {
	Scanner sc;
	public void main(String[] args) {
		// TODO Auto-generated method stub
		sc = new Scanner(System.in);
		int C = sc.nextInt();
		for(int i=0;i<C;i++) {
			findDunibal();
		}
	}
	public void findDunibal() {
		int[][] adjmat;
		int[][] cache;
		int N = sc.nextInt();
		adjmat = new int[N][N];
		int D = sc.nextInt();
		cache = new int[D][N];
		for(int i=0;i<D;i++) {
			for(int j=0;i<N;j++)
				cache[i][j] = 0;
		}
		for(int i=0;i<N;i++) {
			for(int j=0;j<D;j++) {
				adjmat[i][j] = sc.nextInt();
			}
		}
		

		int T = sc.nextInt();
		int[] ttown = new int[T];
		for(int i=0;i<T;i++) {
			
		}
	}

}
