package nl.dslmeinte.xtext.less.test

import nl.dslmeinte.xtext.less.LessStandaloneSetup
import org.eclipse.emf.ecore.resource.Resource$Diagnostic
import org.eclipse.emf.ecore.util.Diagnostician
import org.eclipse.xtext.junit.AbstractXtextTests
import org.junit.Assert

class ExamplesTest extends AbstractXtextTests {

	private Diagnostician diagnostician

	override protected setUp() {
		super.setUp()
		with(typeof(LessStandaloneSetup));
		diagnostician = new Diagnostician()
	}

	def void test_all_examples_at_once() {
		val path = ^class.^package.name.replace('.', '/') + "/examples.less"
		val cssFile = getModelAndExpect(^class.classLoader.getResourceAsStream(path), Integer::MIN_VALUE)	// TODO  -> UNKNOWN_EXPECTATION

		val resource = cssFile.eResource

		for( e : resource.errors ) {
			e.print("error")
		}
//		resource.errors.map [it.print("error")]

		for( w : resource.warnings ) {
			w.print("warning")
		}
//		resource.warnings.map [println("warning:\t" + it)]

		val issues = diagnostician.validate(cssFile).children
		for( i : issues ) {
			i.print
		}
//		issues.map [println("issue:\t" + it)]
		if( issues.size > 0 || resource.errors.size > 0 ) {
			Assert::fail("there were syntactic errors and/or semantic issues")
		}
	}

	def private print(Diagnostic it, String type) {
		println( '''LÇlineÈÇsafeColumnÈ		ÇtypeÈ		ÇmessageÈ'''.toString )
	}

	def private print(org.eclipse.emf.common.util.Diagnostic it) {
		println( '''ÇseverityÈ	ÇmessageÈ'''.toString )		// TODO  map severity int -> String
	}

	def private safeColumn(Diagnostic it) {
		try {
			"@" + column
		} catch( UnsupportedOperationException e ) {
			""
		}
	}

}
