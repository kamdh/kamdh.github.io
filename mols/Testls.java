import lsPackage.*;

public class Testls {
	final static int[] BLOCK_SIZE = {/*H=rows*/ 2, /*W=cols*/ 2};  //HxW subblocks
	final static int SIZE = BLOCK_SIZE[0]*BLOCK_SIZE[1];
	
	public static void main(String[] args) {
		LatinSquare ls = new LatinSquare(SIZE);
		
		/*
		for (int i = 0; i < SIZE; i++)
			for (int j = 0; j < SIZE; j++)
				ls.data[i][j] = (i + j)%SIZE;
		*/
		
		//valid sudoku:
		int[][] t = {
			{0, 1, 2, 3},
			{2, 3, 0, 1},
			{1, 0, 3, 2},
			{3, 2, 1, 0}
		};
		ls.setData(t);
		
		//test basic functions
		ls.disp();		
		System.out.println("\nThe entry at row 3, col 1 is: " + ls.entry(1,1));
		System.out.println("The size is: " + ls.size());
		System.out.println("Latin square? " + ls.isLegal());
		System.out.println("Sudoku? " + ls.isSudoku());
		
		System.out.println("\n=====\n");
		
		//test isOrtho
		LatinSquare aLS = new LatinSquare();
		LatinSquare bLS = new LatinSquare();
		
		int[][] a = {{0,1,2},{1,2,0},{2,0,1}};
		aLS.setData(a);
		System.out.println("A:");
		aLS.disp();
		
		int[][] b = {{0,1,2},{2,0,1},{1,2,0}};
		bLS.setData(b);
		System.out.println("B:");
		bLS.disp();
		
		if (LatinSquare.areOrtho(aLS, bLS))
			System.out.println("\nA and B orthogonal");
		else
			System.out.println("\nA and B not orthogonal");
			
		System.out.println("A==B? " + aLS.equals(bLS));
		System.out.println("A==A? " + aLS.equals(aLS));
	
	}
}