package nl.dslmeinte.xtext.css.test

import nl.dslmeinte.xtext.css.CSSStandaloneSetup
import nl.dslmeinte.xtext.test.util.XtextTestsSupport
import org.eclipse.xtext.junit.AbstractXtextTests

class SelectorsTests extends XtextTestsSupport {

	override protected setUp() {
		super.setUp()
		with(typeof(CSSStandaloneSetup));
	}

	def void test_all_positive_tests_at_once() {
		test("bigPositiveTest.css".fileInCurrentJavaPackage)
	}

	def void test_section5_example2_part1() {
		getModelAndExpect( "h1 { font-family: sans-serif }
							h2..foo { font-family: sans-serif }
							h3 { font-family: sans-serif }", AbstractXtextTests::EXPECT_ERRORS )
	}

	def void test_section5_example2_part2() {
		getModelAndExpect( "h1, h2..foo, h3 { font-family: sans-serif }", AbstractXtextTests::EXPECT_ERRORS )
	}

	def void test_anomolousTest1() {
		test("anomolousTest1.css".fileInCurrentJavaPackage)
	}

	def void test_mixinsNested() {
		test("mixins-nested.css".fileInCurrentJavaPackage)
	}

}

