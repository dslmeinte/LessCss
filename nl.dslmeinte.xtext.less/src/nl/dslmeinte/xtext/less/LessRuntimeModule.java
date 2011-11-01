package nl.dslmeinte.xtext.less;

import nl.dslmeinte.xtext.less.services.LessValueConverterService;

import org.eclipse.xtext.conversion.IValueConverterService;

public class LessRuntimeModule extends AbstractLessRuntimeModule {

//	public Class<? extends IQualifiedNameProvider> bindIQualifiedNameProvider() {
//		return LessNamingProvider.class;
//	}

	public Class<? extends IValueConverterService> bindIValueConverterService() {
		return LessValueConverterService.class;
	}

}
