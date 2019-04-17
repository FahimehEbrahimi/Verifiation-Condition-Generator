package Tree;

public class Ident extends Exp {

    private String name;
    public Ident(String name) {

        this.name = name;
    }

    public String getName() {

        return name;
    }

    public void print() {

        System.out.print(name);
    }

    public Exp Substitute(Ident ident, Exp exp) {

        if (this.name.equals(ident.getName())) {
            return exp;
        }
        return this;
    }
}
