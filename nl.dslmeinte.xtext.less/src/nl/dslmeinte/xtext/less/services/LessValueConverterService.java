package nl.dslmeinte.xtext.less.services;

import nl.dslmeinte.xtext.css.services.CSSValueConverterService;

import org.eclipse.xtext.conversion.IValueConverter;
import org.eclipse.xtext.conversion.ValueConverter;
import org.eclipse.xtext.nodemodel.INode;

public class LessValueConverterService extends CSSValueConverterService {

	@ValueConverter(rule = "AT_ID")
	public IValueConverter<String> AT_ID() {
		return new IValueConverter<String>() {
			@Override
			public String toString(String value) {
				return '@' + value;
			}
			@Override
			public String toValue(String string, INode node) {
				return string.substring(1);
			}
		};
	}

}
