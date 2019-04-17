package Tree;

public class WhileStatement extends Statement {

    private Exp loopInvariant;
    private Exp condition;
    private Statement body;

    public WhileStatement(Exp i, Exp b, Statement s) {

        this.loopInvariant = i;
        this.condition = b;
        this.body = s;
    }

    public Exp WeakestPrecondition(Exp exp) {

        new OpExp(new OpExp(this.loopInvariant,
			       	OpExp.Op.AND, 
				new OpExp(OpExp.Op.NOT, this.condition)), 
				OpExp.Op.IMP, exp).print();
        System.out.println();

        new OpExp(new OpExp(this.loopInvariant, OpExp.Op.AND, this.condition),
		       		OpExp.Op.IMP, this.body.WeakestPrecondition(this.loopInvariant)).print();
        System.out.println();
        return this.loopInvariant;
    }
}
