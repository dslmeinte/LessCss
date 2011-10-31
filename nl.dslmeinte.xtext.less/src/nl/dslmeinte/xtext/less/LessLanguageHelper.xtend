package nl.dslmeinte.xtext.less

import com.google.inject.Inject

import org.eclipse.xtext.naming.IQualifiedNameConverter
import org.eclipse.xtext.naming.QualifiedName

import nl.dslmeinte.xtext.css.css.ClassSelector
import nl.dslmeinte.xtext.less.less.LessFile
import nl.dslmeinte.xtext.less.less.RuleSet
import nl.dslmeinte.xtext.less.less.ToplevelSelectorIndirection

class LessLanguageHelper {

	def mixinCandidates(LessFile lessFile) {
		val candidates = lessFile.statements.filter(typeof(RuleSet)).filter([RuleSet rs|rs.canBeMixin])
		println(candidates.map([rs|rs.qName]))
		candidates
	}

	def canBeMixin(RuleSet ruleSet) {
		   ruleSet.selectors.size == 1
		&& ruleSet.selectors.head instanceof ToplevelSelectorIndirection
		&& (ruleSet.selectors.head as ToplevelSelectorIndirection).selector instanceof ClassSelector
	}

	@Inject
	extension IQualifiedNameConverter qNameConverter

	def qName(RuleSet ruleSet) {
		if( !ruleSet.canBeMixin ) {
			throw new IllegalArgumentException("can only compute q-name for rule set that can act as mixin")
		}
		((ruleSet.selectors.head as ToplevelSelectorIndirection).selector as ClassSelector).name.toQualifiedName
	}

}

