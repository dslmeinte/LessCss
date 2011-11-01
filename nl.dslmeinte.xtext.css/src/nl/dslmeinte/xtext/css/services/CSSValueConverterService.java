package nl.dslmeinte.xtext.css.services;

import org.eclipse.xtext.common.services.DefaultTerminalConverters;
import org.eclipse.xtext.conversion.IValueConverter;
import org.eclipse.xtext.conversion.ValueConverter;
import org.eclipse.xtext.conversion.ValueConverterException;
import org.eclipse.xtext.nodemodel.INode;

public class CSSValueConverterService extends DefaultTerminalConverters {

	@ValueConverter(rule="HASH_ID")
	public IValueConverter<String> HASH_ID() {
		return new IValueConverter<String>() {
			@Override
			public String toString(String value) {
				return "#" + value;
			}
			@Override
			public String toValue(String string, INode node) {
				return string.substring(1);
			}
		};
	}

	@ValueConverter(rule="DOT_ID")
	public IValueConverter<String> DOT_ID() {
		return new IValueConverter<String>() {
			@Override
			public String toString(String value) {
				return "." + value;
			}
			@Override
			public String toValue(String string, INode node) {
				return string.substring(1);
			}
		};
	}

	@ValueConverter(rule="RGB_COLOR")
	public IValueConverter<String> RGB_COLOR() {
		return new IValueConverter<String>() {
			@Override
			public String toString(String value) {
				return "#" + value;
			}
			@Override
			public String toValue(String string, INode node)
					throws ValueConverterException {
				if( string.length() == 4 || string.length() == 7 ) {
					return string.substring(1);
				}
				throw new ValueConverterException("'" + string + "' is not a valid RGB color code", node, null);
			}
		};
	}

}
