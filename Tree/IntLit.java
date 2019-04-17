package Tree;

public class IntLit extends Exp {

    private int value;
    public IntLit(int value) {
        this.value = value;
    }

    public void print() {

        System.out.print(value);
    }

    public Exp Substitute(Ident ident, Exp exp) {

        return this;
    }
}
