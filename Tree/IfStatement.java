package Tree;


public class IfStatement extends Statement {

    private Exp condition;
    private Statement thenStatement;
    private Statement elseStatement;

    public IfStatement(Exp b, Statement s1, Statement s2) {

        this.condition = b;
        this.thenStatement = s1;
        this.elseStatement = s2;
    }

    public Exp WeakestPrecondition(Exp exp) {
        return new OpExp(new OpExp(this.condition, OpExp.Op.IMP, this.thenStatement.WeakestPrecondition(exp)),
			OpExp.Op.AND, 
			new OpExp(new OpExp(OpExp.Op.NOT, this.condition), OpExp.Op.IMP, this.elseStatement.WeakestPrecondition(exp)));
    }
}
