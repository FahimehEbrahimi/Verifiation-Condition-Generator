grammar IMP;

@header {
    package Parse;
    import Tree.*;
}

program
    : pre=assertion stmt=statementlist post=assertion
		{
		    new OpExp($pre.tree, OpExp.Op.IMP, $stmt.tree.WeakestPrecondition($post.tree)).print();
                    System.out.println();
		}
    ;

statementlist returns [Statement tree]
    : s=statement
      { $tree = $s.tree; }
    | s1=statement ';' s2=statementlist
      { $tree = new Semicolon($s1.tree, $s2.tree); }
    ;

statement returns [Statement tree]
    : 'skip'
        { $tree=new Skip(); }
    | id ':=' exp = arithexp
        { $tree = new Substitution($id.name, $exp.tree); }
    | 'begin' st = statementlist 'end'
        { $tree = $st.tree; }
    | 'if' b=boolterm 'then' s1=statement 'else' s2=statement
      { $tree = new IfStatement($b.tree, $s1.tree, $s2.tree); }
    | ws=assertion 'while' b=boolterm 'do' s=statement
      { $tree = new WhileStatement($ws.tree, $b.tree, $s.tree); }
    | 'assert' as=assertion
      { $tree = new Assert($as.tree); }
    ;

assertion returns [Exp tree]
    : '{' t=boolexp '}'
		{ $tree = $t.tree; }
    ;

boolexp returns [Exp tree]
    : t=boolterm
		{ $tree = $t.tree; }
    | b1=boolterm '=>' b2=boolterm
                { $tree = new OpExp($b1.tree, OpExp.Op.IMP, $b2.tree); }
    | b1=boolterm '<=>' b2=boolterm
                { $tree = new OpExp($b1.tree, OpExp.Op.EQV, $b2.tree); }
    ;

boolterm returns [Exp tree]
    : t=boolterm2
		{ $tree = $t.tree; }
    | b1=boolterm 'or' b2=boolterm2
                { $tree = new OpExp($b1.tree, OpExp.Op.OR, $b2.tree); }
    ;

boolterm2 returns [Exp tree]
    : b=boolfactor
		{ $tree = $b.tree; }
    | b1=boolterm2 'and' b2=boolfactor
                { $tree = new OpExp($b1.tree, OpExp.Op.AND, $b2.tree); }
    ;

boolfactor returns [Exp tree]
    : 'true'    { $tree = new BoolLit(true); }
    | 'false'   { $tree = new BoolLit(false); }
    | compexp
		{ $tree = $compexp.tree; }
    | 'forall' id '.' b = boolexp
       { $tree = new QuantExp(QuantExp.QuantifierType.FORALL, $id.name, $b.tree); }
    | 'exists' id '.' b = boolexp
       { $tree = new QuantExp(QuantExp.QuantifierType.EXISTS, $id.name, $b.tree); }
    | 'not' bf=boolfactor
                { $tree = new OpExp(OpExp.Op.NOT, $bf.tree); }
    | '(' t=boolexp ')'
		{ $tree = $t.tree; }
    ;

compexp returns [Exp tree]
    : exp1=arithexp '<' exp2=arithexp
                { $tree = new OpExp($exp1.tree, OpExp.Op.LT, $exp2.tree); }
    | exp1=arithexp '<=' exp2=arithexp
                { $tree = new OpExp($exp1.tree, OpExp.Op.LE, $exp2.tree); }
    | exp1=arithexp '=' exp2=arithexp
		{ $tree = new OpExp($exp1.tree, OpExp.Op.EQ, $exp2.tree); }
    | exp1=arithexp '!=' exp2=arithexp
		{ $tree = new OpExp($exp1.tree, OpExp.Op.NE, $exp2.tree); }
    | exp1=arithexp '>=' exp2=arithexp
		{ $tree = new OpExp($exp1.tree, OpExp.Op.GE, $exp2.tree); }
    | exp1=arithexp '>' exp2=arithexp
		{ $tree = new OpExp($exp1.tree, OpExp.Op.GT, $exp2.tree); }
    ;

arithexp returns [Exp tree]
    : t=arithterm
		{ $tree = $t.tree; }
    | exp=arithexp '+' term=arithterm
		{ $tree = new OpExp($exp.tree, OpExp.Op.PLUS, $term.tree); }
    | exp=arithexp '-' term=arithterm
		{ $tree = new OpExp($exp.tree, OpExp.Op.MINUS, $term.tree); }
    ;

arithterm returns [Exp tree]
    : t=arithfactor
		{ $tree = $t.tree; }
    | t1=arithterm '*' t2=arithfactor
		{ $tree = new OpExp($t1.tree, OpExp.Op.TIMES, $t2.tree); }
    | t1=arithterm '/' t2=arithfactor
		{ $tree = new OpExp($t1.tree, OpExp.Op.DIV, $t2.tree); }
    ;

arithfactor returns [Exp tree]
    : id
		{ $tree = $id.name; }
    | integer
		{ $tree = $integer.value; }
    | '-' factor=arithfactor
                { $tree = new OpExp(OpExp.Op.UMINUS, $factor.tree); }
    | '(' t=arithexp ')'
		{ $tree = $t.tree; }
    | id '(' expList = arithexplist ')'
                { $tree = new FunctionCallExp($id.name, $expList.paramList); }
    ;

arithexplist returns [java.util.LinkedList<Exp> paramList]
    : exp = arithexp
      { 
        $paramList = new java.util.LinkedList(); 
        $paramList.add($exp.tree); 
      }
    | exp = arithexp ',' expList = arithexplist
      { 
        $paramList = new java.util.LinkedList(); 
        $paramList.add($exp.tree); 
        $paramList.addAll($expList.paramList); 
      }
    ;

id returns [Ident name]
    : IDENT
		{ $name = new Ident($IDENT.text); }
    ;

integer returns [IntLit value]
    : INT
		{ $value = new IntLit(Integer.parseInt($INT.text)); }
    ;


IDENT
    : [A-Za-z][A-Za-z0-9_]*
    ;

INT
    : [0]|[1-9][0-9]*
    ;

WS
    : [ \r\n\t] -> skip
    ;
