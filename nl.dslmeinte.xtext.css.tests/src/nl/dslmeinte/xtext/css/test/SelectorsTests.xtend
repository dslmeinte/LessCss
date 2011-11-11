package nl.dslmeinte.xtext.css.test

import nl.dslmeinte.xtext.css.CSSStandaloneSetup
import org.eclipse.emf.ecore.resource.Resource$Diagnostic
import org.eclipse.emf.ecore.util.Diagnostician
import org.eclipse.xtext.junit.AbstractXtextTests
import org.junit.Assert

class SelectorsTests extends AbstractXtextTests {

	private Diagnostician diagnostician

	override protected setUp() {
		super.setUp()
		with(typeof(CSSStandaloneSetup));
		diagnostician = new Diagnostician()
	}

	def void test_all_positive_tests_at_once() {
		testFile("bigPositiveTest.css")
	}

	def void test_section5_example2_part1() {
		getModelAndExpect( "h1 { font-family: sans-serif }
							h2..foo { font-family: sans-serif }
							h3 { font-family: sans-serif }", 6 )
	}

	def void test_section5_example2_part2() {
		getModelAndExpect( "h1, h2..foo, h3 { font-family: sans-serif }", 6 )
	}

	def void test_anomolousTest1() {
		testFile("anomolousTest1.css")
	}

	def void test_mixinsNested() {
		testFile("mixins-nested.css")
	}

	def private testFile(String fileName) {
		val path = ^class.^package.name.replace('.', '/') + "/" + fileName
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
			println("")
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

