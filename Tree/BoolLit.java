package Tree;

public class BoolLit extends Exp {

    private boolean value;
    public BoolLit(boolean value) {

        this.value = value;
    }

    public void print() {

        System.out.print(value);
    }

    public Exp Substitute(Ident ident, Exp exp) {

        return this;
    }
}
