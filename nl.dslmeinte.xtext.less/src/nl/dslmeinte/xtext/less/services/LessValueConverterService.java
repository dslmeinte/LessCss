package nl.dslmeinte.xtext.less.services;

import org.eclipse.xtext.conversion.IValueConverter;
import org.eclipse.xtext.conversion.ValueConverter;
import org.eclipse.xtext.conversion.ValueConverterException;
import org.eclipse.xtext.conversion.impl.AbstractDeclarativeValueConverterService;
import org.eclipse.xtext.conversion.impl.INTValueConverter;
import org.eclipse.xtext.conversion.impl.STRINGValueConverter;
import org.eclipse.xtext.nodemodel.INode;

import com.google.inject.Inject;

public class LessValueConverterService extends AbstractDeclarativeValueConverterService {

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

	@ValueConverter(rule="HEX_COLOR")
	public IValueConverter<String> HEX_COLOR() {
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

	@ValueConverter(rule="URL")
	public IValueConverter<String> URL() {
		return new IValueConverter<String>() {
			@Override
			public String toString(String value) {
				return "url(" + value + ")";
			}
			@Override
			public String toValue(String string, INode node) {
				return string.substring(4, string.length()-1).trim();
			}
		};
	}

	@Inject
	private INTValueConverter intValueConverter;
	
	@ValueConverter(rule = "INT")
	public IValueConverter<Integer> INT() {
		return intValueConverter;
	}

	@Inject
	private STRINGValueConverter stringValueConverter;
	
	@ValueConverter(rule = "STRING")
	public IValueConverter<String> STRING() {
		return stringValueConverter;
	}

}
