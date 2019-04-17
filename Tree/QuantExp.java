package Tree;

import java.io.PrintStream;

public class QuantExp extends Exp {

   // private final QuantifierType quantType;
   // private final Ident ident;
   // private final Exp exp;

    public static enum QuantifierType
    {
	    FORALL,
	    EXISTS;
    }

    private static String[] quantifierNames = {"forall ","exists "};

    private QuantifierType quantType;
    private Ident ident;
    private Exp exp;

    public QuantExp(QuantifierType quantType, Ident ident, Exp exp) {

        this(quantType, ident, exp, true);
    }

    private QuantExp(QuantifierType quantType, Ident ident1, Exp exp, boolean isFirst) {

        this.quantType = quantType;
        if (isFirst) {
            this.ident = new Ident("$" + ident1.getName());
            this.exp = exp.Substitute(ident1, this.ident);
        } else {
            this.ident = ident1;
            this.exp = exp;
        }
    }

    public void print() {

        System.out.print(quantifierNames[quantType.ordinal()]);
        this.ident.print();
        System.out.print('.');
        this.exp.print();
    }

    public Exp Substitute(Ident ident, Exp exp) {

        return new QuantExp(quantType, this.ident, exp.Substitute(ident, exp), false);
    }
}
