package Tree;

public class Substitution extends Statement {

    private Ident ident;
    private Exp exp;

    public Substitution(Ident ident, Exp exp) {
        
        this.ident = ident;
        this.exp = exp;
    }

    public Exp WeakestPrecondition(Exp exp1) {
        
        return exp1.Substitute(this.ident, this.exp);
    }
}
