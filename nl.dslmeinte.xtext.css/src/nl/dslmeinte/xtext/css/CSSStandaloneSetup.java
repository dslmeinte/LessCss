
package nl.dslmeinte.xtext.css;

/**
 * Initialization support for running Xtext languages 
 * without equinox extension registry
 */
public class CSSStandaloneSetup extends CSSStandaloneSetupGenerated{

	public static void doSetup() {
		new CSSStandaloneSetup().createInjectorAndDoEMFRegistration();
	}
}

