package nl.dslmeinte.xtext.less.validation;

import nl.dslmeinte.xtext.less.less.AttributeSelector;
import nl.dslmeinte.xtext.less.less.StringAttributeValueLiteral;
import nl.dslmeinte.xtext.less.less.StringLiteral;

import org.eclipse.xtext.validation.Check;

public class LessJavaValidator extends AbstractLessJavaValidator {

	@Check
	public void checkStringInterpolation(AttributeSelector attributeSelector) {
		// .value is ID, STRING or INT: ID and INT can't have interpolation characters lexer-wise, so check .value as-is:
		if( attributeSelector.getValue() instanceof StringAttributeValueLiteral ) {
			checkStringInterpolation(((StringAttributeValueLiteral) attributeSelector.getValue()).getValue());
		}
	}

	@Check
	public void checkStringInterpolation(StringLiteral stringLiteral) {
		checkStringInterpolation(stringLiteral.getValue());
	}

	private void checkStringInterpolation(String string) {
		// TODO  implement, but need evaluation engine for that
	}

}
