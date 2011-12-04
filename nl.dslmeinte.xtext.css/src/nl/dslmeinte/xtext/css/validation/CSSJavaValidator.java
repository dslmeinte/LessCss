package nl.dslmeinte.xtext.css.validation;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import nl.dslmeinte.xtext.css.css.ColorComponentLiteral;
import nl.dslmeinte.xtext.css.css.ComponentHSLColor;
import nl.dslmeinte.xtext.css.css.ComponentRGBColor;
import nl.dslmeinte.xtext.css.css.CssPackage;
import nl.dslmeinte.xtext.css.css.DecimalLiteral;
import nl.dslmeinte.xtext.css.css.IntegerLiteral;
import nl.dslmeinte.xtext.css.css.LanguagePseudoClassSelector;
import nl.dslmeinte.xtext.css.css.NumberLiteral;

import org.eclipse.emf.ecore.EStructuralFeature;
import org.eclipse.xtext.validation.Check;

public class CSSJavaValidator extends AbstractCSSJavaValidator {

	private static final CssPackage ePackage = CssPackage.eINSTANCE;

	private static final Matcher languagePatternMatcher = Pattern.compile("\\w+(-\\w+)?").matcher("");

	@Check
	public void checkLanguageId(LanguagePseudoClassSelector languageSelector) {
		languagePatternMatcher.reset(languageSelector.getLangugageId());
		if( !languagePatternMatcher.matches() ) {
			error( "not a valid language identifier", ePackage.getLanguagePseudoClassSelector_LangugageId());
		}
	}

	@Check
	public void checkComponentRGBColor(ComponentRGBColor componentRGBColor) {
		boolean percentage = componentRGBColor.getRed().isPercentage();
		checkRGBComponent(componentRGBColor, ePackage.getComponentRGBColor_Red(), percentage);
		checkRGBComponent(componentRGBColor, ePackage.getComponentRGBColor_Green(), percentage);
		checkRGBComponent(componentRGBColor, ePackage.getComponentRGBColor_Blue(), percentage);
	}

	private void checkRGBComponent(ComponentRGBColor componentRGBColor, EStructuralFeature feature, boolean percentage) {
		ColorComponentLiteral value = (ColorComponentLiteral) componentRGBColor.eGet(feature);
		if( percentage ) {
			checkPercentage(value, feature);
		} else {
			if( value.isPercentage() ) {
				error("cannot be a percentage", feature);
			}
			NumberLiteral number = value.getNumber();
			if( number instanceof DecimalLiteral ) {
				error("must be an integer", feature);
			} else {
				int intValue = ((IntegerLiteral) number).getInt();
				if( !(0 <= intValue && intValue <= 255) ) {
					error("must be in the range 0-255", feature);
				}
			}
		}
	}

	private void checkPercentage(ColorComponentLiteral value, EStructuralFeature feature) {
		if( !value.isPercentage() ) {
			error("must be a percentage", feature);
		}
		if( value instanceof IntegerLiteral ) {
			int intValue = ((IntegerLiteral) value).getInt();
			if( !(0 <= intValue && intValue <= 100) ) {
				error("must be in the 0-100% range", feature);
			}
		}
		if( value instanceof DecimalLiteral ) {
			double decimalValue = ((DecimalLiteral) value).getDecimal();
			if( !(0.0 <= decimalValue && decimalValue <= 100.0) ) {
				error("must be in the 0-100% range", feature);
			}
		}
	}

	@Check
	public void checkComponentHSLColor(ComponentHSLColor componentHSLColor) {
		checkHSLComponent(componentHSLColor, ePackage.getComponentHSLColor_Hue());
		checkHSLComponent(componentHSLColor, ePackage.getComponentHSLColor_Saturation());
		checkHSLComponent(componentHSLColor, ePackage.getComponentHSLColor_Lightness());
	}

	private void checkHSLComponent(ComponentHSLColor componentHSLColor, EStructuralFeature feature) {
		ColorComponentLiteral value = (ColorComponentLiteral) componentHSLColor.eGet(feature);
		checkPercentage(value, feature);
	}

}
