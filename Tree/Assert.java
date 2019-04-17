package Tree;

public class Assert extends Statement {

    private Exp condition;

    public Assert(Exp exp) {

        this.condition = exp;
    }

    public Exp WeakestPrecondition(Exp exp) {
        new OpExp(this.condition, OpExp.Op.IMP, exp).print();
        System.out.println();
        return this.condition;
    }
}
