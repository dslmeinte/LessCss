package nl.dslmeinte.xtext.less

import com.google.inject.Inject

import org.eclipse.xtext.naming.IQualifiedNameConverter
import org.eclipse.xtext.naming.QualifiedName

import nl.dslmeinte.xtext.css.css.ClassSelector
import nl.dslmeinte.xtext.less.less.LessFile
import nl.dslmeinte.xtext.less.less.RuleSet
import nl.dslmeinte.xtext.less.less.SimpleSelectorIndirection

class LessLanguageHelper {

	def mixinCandidates(LessFile lessFile) {
		lessFile.statements.filter(typeof(RuleSet)).filter([RuleSet rs|rs.canBeMixin])
	}

	def canBeMixin(RuleSet ruleSet) {
		ruleSet.atomicClassName != null
	}

	@Inject
	extension IQualifiedNameConverter qNameConverter

	def qName(RuleSet ruleSet) {
		if( !ruleSet.canBeMixin ) {
			throw new IllegalArgumentException("can only compute q-name for rule set that can act as mixin")
		}
		ruleSet.atomicClassName.toQualifiedName
	}

	def atomicClassName(RuleSet ruleSet) {
		if( ruleSet.selectors.size != 1 ) {
			return null
		}
		val atomicSelector = ruleSet.selectors.head
		if( !(atomicSelector instanceof SimpleSelectorIndirection) ) {
			return null
		}
		val indirection = (atomicSelector as SimpleSelectorIndirection).selector
		if( !(indirection instanceof ClassSelector) ) {
			return null
		}
		(indirection as ClassSelector).name
	}

}

