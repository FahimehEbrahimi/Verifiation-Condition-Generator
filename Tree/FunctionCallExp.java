package Tree;

//import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Iterator;

public class FunctionCallExp extends Exp {

    private Ident functionName;
//    private  ArrayList<Exp> args;
     private LinkedList<Exp> args;
     private Iterator<Exp> iter;

    public FunctionCallExp(Ident functionName, LinkedList<Exp> params) {
        this.functionName = functionName;
        this.args = params;
	iter = params.iterator();
    }

    public void print() {

        functionName.print();
        System.out.print("(");
  	
	iter = this.args.iterator();
	((Exp)iter.next()).print();
	while (iter.hasNext())
	{
		System.out.print(",");
		((Exp)iter.next()).print();
	}
        System.out.print(")");

    }

    public Exp Substitute(Ident ident, Exp exp) {

        LinkedList<Exp> newParams = new LinkedList();
	iter = args.iterator();
	newParams.add(((Exp)iter.next()).Substitute(ident, exp));
	while (iter.hasNext())
	{
		newParams.add(((Exp)iter.next()).Substitute(ident, exp));
	}
        return new FunctionCallExp(this.functionName, newParams);
    }
}
