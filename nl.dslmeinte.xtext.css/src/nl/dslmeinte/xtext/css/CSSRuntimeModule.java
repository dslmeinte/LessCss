package nl.dslmeinte.xtext.css;

import nl.dslmeinte.xtext.css.services.CSSValueConverterService;

import org.eclipse.xtext.conversion.IValueConverterService;

public class CSSRuntimeModule extends AbstractCSSRuntimeModule {

	public Class<? extends IValueConverterService> bindIValueConverterService() {
		return CSSValueConverterService.class;
	}

}
