import lsPackage.*;

public class TestBlock {
	final static int[] BLOCK_SIZE = {/*H*/ 5, /*W*/ 3};  //HxW subblocks
	final static int SIZE = BLOCK_SIZE[0]*BLOCK_SIZE[1];
	
	public static void main(String[] args) {
		Block b00 = new Block(BLOCK_SIZE);
		Block tmp = new Block(BLOCK_SIZE);
		
		int[][] init =
			{{0,1,2},
			 {3,4,5},
			 {6,7,8},
			 {9,10,11},
			 {12,13,14}};
		b00.setData(init);
		
		//show all permutations of b00
		for (int i=0; i < BLOCK_SIZE[1]; i++)
			for (int j=0; j < BLOCK_SIZE[0]; j++) {				
				tmp = Block.getRotation(b00,i,j);
				
				System.out.println("\nBlock " + i + j + ":");
				tmp.disp();
			}
			
	}//main
}