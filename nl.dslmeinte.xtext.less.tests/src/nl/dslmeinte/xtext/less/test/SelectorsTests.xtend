package nl.dslmeinte.xtext.less.test

import nl.dslmeinte.xtext.less.LessStandaloneSetup
import nl.dslmeinte.xtext.test.util.XtextTestsSupport
import org.eclipse.xtext.junit.AbstractXtextTests

class SelectorsTests extends XtextTestsSupport {

	override protected setUp() {
		super.setUp()
		with(typeof(LessStandaloneSetup));
	}

	def void test_all_positive_tests_at_once() {
		test("bigPositiveTest.less".fileInCurrentJavaPackage)
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
		test("anomolousTest1.less".fileInCurrentJavaPackage)
	}

	def void test_mixinsNested() {
		test("mixins-nested.less".fileInCurrentJavaPackage)
	}

}

