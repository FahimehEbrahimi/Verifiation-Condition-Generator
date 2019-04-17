package Tree;

public class Semicolon extends Statement {

    private Statement s1;
    private Statement s2;

    public Semicolon(Statement s1, Statement s2) {

        this.s1 = s1;
        this.s2 = s2;
    }

    public Exp WeakestPrecondition(Exp exp) {

        return s1.WeakestPrecondition(s2.WeakestPrecondition(exp));
    }
}
