
package nl.dslmeinte.xtext.less;

/**
 * Initialization support for running Xtext languages 
 * without equinox extension registry
 */
public class LessStandaloneSetup extends LessStandaloneSetupGenerated{

	public static void doSetup() {
		new LessStandaloneSetup().createInjectorAndDoEMFRegistration();
	}
}

