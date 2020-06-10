package lsPackage;

public class Block implements Cloneable {
	int[][] data;
	int[] dim;
	int	height,
			width,
			elts;
	
	public Block() {
	}
	
	public Block(int[] c /*HxW*/) {
		data = new int[c[0]][c[1]];
		dim = c.clone();
		height = dim[0];
		width = dim[1];
		elts = height*width;
	}
	
	//display
	public void disp() {
		int i, j;
		for (i = 0; i < height; i++) {
			for (j = 0; j < width; j++)
				System.out.printf("%4d", data[i][j]);
			System.out.print("\n");
		}
	}
	
	/* method:	setData
		pre:		int[][]
		post:		void
		
		set local variable data */
	public void setData(int[][] in) {
		//deep copy
		for (int i = 0; i < in.length; i++)
			for (int j = 0; j < in[0].length; j++)
				data[i][j] = in[i][j];
	}
	
	/* method:	getData
		pre:		void
		post:		int[][]
		
		return local data */
	public int[][] getData() {
		int[][] ret = new int[height][width];
		
		//deep copy
		for (int i = 0; i < height; i++)
			for (int j = 0; j < width; j++)
				ret[i][j] = data[i][j];
		
		return ret;
	}
	
	/* method:	getRotation
		pre:		Block - consider like "00"
					int	- column rotations
					int	- row rotations
		post:		Block
		
		get a specific rotation of 00 given col_rots, row_rots */
	public static Block getRotation(Block zero, int col_rots, int row_rots) {
		Block tmp = zero.rotateCol(zero,col_rots);
		tmp = zero.rotateRow(tmp,row_rots);
		return tmp;
	
	}//getRotation
	
	public Block clone() {
		int i = 0,
		 j = 0;
		int[] newDim = new int[2];
		int[][] newData = new int[height][width];

		//copy dim -> newDim
		for (i = 0; i < 2; i++)
			newDim[i]=dim[i];
	
		Block newBlk = new Block(newDim);
	
		//copy data -> newBlk.data
		for (i = 0; i < height; i++)
			for (j = 0; j < width; j++)
				newBlk.data[i][j] = data[i][j];
	
		return newBlk;
	}
	
	//SECTION: PRIVATE
	/* method:	rotateCol */
	private static Block rotateCol(Block zero, int c) {
		Block ret = new Block(zero.dim);
		int[][] retData = zero.getData();
		int[][] tracker = zero.getData();
		
		for (int k = 0; k < c; k++) {
			for (int i = 0; i < zero.height; i++)
				for (int j = 0; j < zero.width; j++)
					retData[i][j] = tracker[i][(j+1)%zero.width];
			//set tracker=retData before next iteration
			for (int i = 0; i < zero.height; i++)
				for (int j = 0; j < zero.width; j++)
					tracker[i][j] = retData[i][j];
		}
		
		ret.setData(retData);

		return ret;
	}
	
	/* method:	rotateRow */
	private static Block rotateRow(Block zero, int c) {
		Block ret = new Block(zero.dim);
		int[][] retData = zero.getData();
		int[][] tracker = zero.getData();
		
		for (int k = 0; k < c; k++) {
			for (int i = 0; i < zero.height; i++)
				for (int j = 0; j < zero.width; j++)
					retData[i][j] = tracker[(i+1)%zero.height][j];
			//set tracker=retData before next iteration
			for (int i = 0; i < zero.height; i++)
				for (int j = 0; j < zero.width; j++)
					tracker[i][j] = retData[i][j];
		}
		
		ret.setData(retData);

		return ret;
	}
}