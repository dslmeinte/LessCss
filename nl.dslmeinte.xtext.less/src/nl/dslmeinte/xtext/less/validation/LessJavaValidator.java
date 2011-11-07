package nl.dslmeinte.xtext.less.validation;

import nl.dslmeinte.xtext.css.css.AttributeSelector;
import nl.dslmeinte.xtext.css.css.StringLiteral;

import org.eclipse.xtext.validation.Check;

public class LessJavaValidator extends AbstractLessJavaValidator {

	@Check
	public void checkStringInterpolation(AttributeSelector attributeSelector) {
		// .value is ID or STRING: ID can't have interpolation characters lexer-wise, so check .value as-is:
		checkStringInterpolation(attributeSelector.getValue());
	}

	@Check
	public void checkStringInterpolation(StringLiteral stringLiteral) {
		checkStringInterpolation(stringLiteral.getValue());
	}

	private void checkStringInterpolation(String string) {
		// TODO  implement, but need evaluation engine for that
	}

}
