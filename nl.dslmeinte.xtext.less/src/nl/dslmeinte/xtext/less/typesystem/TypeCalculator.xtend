package nl.dslmeinte.xtext.less.typesystem

import nl.dslmeinte.xtext.less.less.ValueExpression
import nl.dslmeinte.xtext.less.less.CSSLiteral
import nl.dslmeinte.xtext.css.css.ValueLiteral

class TypeCalculator {

	def dispatch void type(ValueExpression expression) {
		throw new IllegalArgumentException("no type calculation defined for ValueExpression sub type " + expression.^class)
	}

	def dispatch type(CSSLiteral expression) {
		expression.value.type
	}

	def dispatch type(ValueLiteral literal) {
		throw new IllegalArgumentException("no type calculation defined for ValueLiteral sub type " + literal.^class)
	}

}
