package nl.dslmeinte.xtext.css.test

import nl.dslmeinte.xtext.css.CSSStandaloneSetup
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
		val path = ^class.^package.name.replace('.', '/') + "/bigPositiveTest.css"
		val cssFile = getModel(^class.classLoader.getResourceAsStream(path))
		val issues = diagnostician.validate(cssFile).children
		if( issues.size > 0 ) {
			// FIXME  the following won't output something?!
			issues.map [println(it.message)]
			Assert::fail
		}
	}

	def void test_section5_example2_part1() {
		getModelAndExpect( "h1 { font-family: sans-serif }
							h2..foo { font-family: sans-serif }
							h3 { font-family: sans-serif }", 6 )
	}

	def void test_section5_example2_part2() {
		getModelAndExpect( "h1, h2..foo, h3 { font-family: sans-serif }", 4 )
	}

}

