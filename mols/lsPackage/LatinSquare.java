package lsPackage;

import java.io.PrintWriter;

public class LatinSquare implements Cloneable {	
	int[][] data;
	int n;
	
	//empty definition
	public LatinSquare() {
	}
	
	//create a latin square of a certain size, assign n the size
	public LatinSquare(int size) {
		data = new int[size][size];
		n = size;
	}
	
	//returns the value at coordinates row,col
	public int entry(int row, int col) {
		return data[row][col];
	}
	
	//return the size of it
	public int size() {
		return n;
	}
	
	//print out the latin square nice and prettily
	public void disp() {
		for (int i=0; i<n; i++) {
			for (int j=0; j<n; j++)
				System.out.printf("%-4d",data[i][j]);
			System.out.print("\n");
		}
		if (n == 0)
			System.out.println("disp error: size zero latin square");
	}
	
	//write the square to a PrintWriter object
	public void write(PrintWriter file) {
		int i, j;
	
		file.print("{");
		for (i = 0; i < n; i++) {
			file.print("{");
			
			for (j = 0; j < n; j++) {
				file.print(data[i][j]);
				if (j != n-1)
					file.print(",");
			}
					
			file.print("}");
			if (i != n-1)
				file.print(",");
		}
		file.println("}");
	}//writeLatinSquare
	
	
	//test whether it is a legal latin square
	public boolean isLegal() {
		int	i,
				j,
				i1,
				j1,
				i2,
				j2;
				
		for (i = 0; i < n; i++)
			for (j = 0; j < n; j++) {
				if ((data[i][j] < 0) || (data[i][j] > n-1))
					return false; 
			}

		for (j = 0; j < n; j++)
			for (i1 = 1; i1 < n; i1++)
				for (i2 = 0; i2 < i1; i2++) {
					if (data[i1][j] == data[i2][j])
						return false;
				}


		for (i = 0; i < n; i++)
			for (j1 = 1; j1 < n; j1++)
				for (j2 = 0; j2 < j1; j2++) {
					if (data[i][j1] == data[i][j2])
						return false;
				}
	
		return true;
	}//isLegal
	
	//test whether it is sudoku
	public boolean isSudoku() {
		int[] tracker = new int[n];
		int	i,
 				j,
				x,
				a,
				b;
		
		
		x = squareRoot(n);
		/*
		//test if the size is a square
		if (x == -1) {
			System.out.println("n = " + n + " is not square");
			return false;		
		}
		*/
		
		for (i = 0; i < x; i++) { //for1
			for (j = 0; j < x; j++) { //for2
		 		for (a = 0; a < n; a++)
					tracker[a] = 0;
					
  				for (a = 0; a < x; a++)
	 				for (b = 0; b < x; b++) { //for3
						(tracker[data[i*x+a][j*x+b]])++;	 
						if (tracker[data[i*x+a][j*x+b]] > 1)
							return false; 
					}//end for3
			}//end for2
		}//end for1
		
		return true;
	}//isSudoku

	public static boolean areOrtho(LatinSquare s1, LatinSquare s2) {
		if(s1.size() == s2.size()) {
		 	int i,
		 		 j,
				 n = s1.size();
			int[][]	s1data = s1.getData(),
						s2data = s2.getData();
		 	
			//initialize tracker
			int[][] tracker = new int[n][n];
		 	for (i = 0; i < n; i++)
				for (j = 0; j < n; j++)
					tracker[i][j] = 0;	
	 		
	 		for (i = 0; i < n; i++)
	 			for (j = 0; j < n; j++) {
				 	//(tracker[s1[i][j]][s2[i][j]])++;
					tracker[s1data[i][j]][s2data[i][j]]++;
				 	if (tracker[s1data[i][j]][s2data[i][j]] > 1)
						return false;
 			   }
		}
		else {
			System.out.println("isOrtho error: squares have different sizes");
			return false;
		}
		//false conditions have been tested
		return true;
	}
	
	//set data with this method
	public void setData(int[][] in) {
		int size = in.length;
		data = new int[size][size];
		n = size;
		
		//deep copy
		for (int i = 0; i < size; i++)
			for (int j = 0; j < size; j++)
				data[i][j] = in[i][j];
	}
	
	//return data as an array
	public int[][] getData() {
		if (data != null) {
			int[][] ret = new int[n][n];
			
			//deep copy
			for (int i = 0; i < n; i++)
				for (int j = 0; j < n; j++)
					ret[i][j] = data [i][j];
			
			return ret;
		}
		else
			System.out.println("getData error: data not initialized");
			return null;
	}
	
	//clone
	public LatinSquare clone() {
		LatinSquare lsClone = new LatinSquare(n);
		//setData implements deep copying
		lsClone.setData(data);
		return lsClone;
	}
	
	//equals
	public boolean equals(LatinSquare other) {
		if (n != other.n) {
			System.out.println("equals error: size mismatch");
			return false;
		}
		for (int i=0; i<n; i++)
			for (int j=0; j<n; j++)
				if (data[i][j] != other.data[i][j])
					return false;
		
		return true;
	}
	
	//SECTION: private
	//take the square root of n
	private static int squareRoot(int n) {
		for (int i = 0; i < n; i++) {
			if (i*i == n)
				return i;
		}
		return -1;
	}//squareRoot

}
