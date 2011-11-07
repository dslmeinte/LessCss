package nl.dslmeinte.xtext.less.evaluation

import nl.dslmeinte.xtext.less.less.AdditiveExpression
import nl.dslmeinte.xtext.less.less.MultiplicativeExpression
import nl.dslmeinte.xtext.less.less.ValueExpression
import nl.dslmeinte.xtext.less.less.ColorFunctionCall
import nl.dslmeinte.xtext.less.less.VariableReference
import nl.dslmeinte.xtext.less.less.ArgumentsReference
import nl.dslmeinte.xtext.less.less.CSSLiteral
import nl.dslmeinte.xtext.less.less.EscapedLiteral
import nl.dslmeinte.xtext.less.less.JavascriptLiteral

class EvaluationEngine {

	def dispatch void evaluate(ValueExpression expression) {
		throw new IllegalArgumentException("no evaluation defined for ValueExpression sub type " + expression.^class )
	}

	def dispatch evaluate(AdditiveExpression expression) {
		
	}

	def dispatch evaluate(MultiplicativeExpression expression) {
		
	}

	def dispatch evaluate(ColorFunctionCall expression) {
		
	}

	def dispatch evaluate(VariableReference expression) {
		
	}

	def dispatch evaluate(ArgumentsReference expression) {
		
	}

	def dispatch evaluate(CSSLiteral expression) {
		
	}

	def dispatch evaluate(EscapedLiteral expression) {
		// TODO  interpolate?
		expression.value
	}

	def dispatch evaluate(JavascriptLiteral expression) {
		// TODO  interpolate?
		expression.value
	}

	
}

