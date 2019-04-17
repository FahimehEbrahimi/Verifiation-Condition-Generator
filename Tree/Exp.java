package Tree;

public abstract class Exp {

    abstract public void print();
    abstract public Exp Substitute(Ident ident, Exp exp);
    void print(OpExp.Op parent, OpExp.LR child) {
        this.print();
    }
}
