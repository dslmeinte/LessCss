package nl.dslmeinte.xtext.less

import com.google.inject.Inject
import java.util.ArrayList
import nl.dslmeinte.xtext.css.css.ClassSelector
import nl.dslmeinte.xtext.css.css.SimpleSelectorSequence
import nl.dslmeinte.xtext.less.less.ExtendedRuleSet
import nl.dslmeinte.xtext.less.less.LessFile
import nl.dslmeinte.xtext.less.less.RuleSetMember
import org.eclipse.xtext.naming.IQualifiedNameConverter
import nl.dslmeinte.xtext.css.css.IDSelector
import org.eclipse.emf.ecore.EObject

class LessLanguageHelper {

	def mixinCandidates(LessFile it) {
		ruleSets.filter [canBeMixin]
	}

	def private canBeMixin(ExtendedRuleSet it) {
		atomicClassName != null
	}

	def namespaceCandidates(LessFile it) {
		ruleSets.filter [canBeNamespace]
	}

	def private canBeNamespace(ExtendedRuleSet it) {
		atomicID != null
	}

	def private ruleSets(LessFile it) {
		statements.filter(typeof(ExtendedRuleSet))
	}

	@Inject
	extension IQualifiedNameConverter qNameConverter

	def qNameMixin(ExtendedRuleSet it) {
		if( atomicClassName == null ) {
			throw new IllegalArgumentException("can only compute q-name for rule set that can act as mixin")
		}
		atomicClassName.toQualifiedName
	}

	def qNameNamespace(ExtendedRuleSet it) {
		if( atomicID == null ) {
			throw new IllegalArgumentException("can only compute q-name for rule set that can act as namespace")
		}
		atomicID.toQualifiedName
	}

	def private atomicClassName(ExtendedRuleSet it) {
		atomicSelector(typeof(ClassSelector))
	}

	def private atomicID(ExtendedRuleSet it) {
		atomicSelector(typeof(IDSelector))
	}

	def private atomicSelector(ExtendedRuleSet it, Class<? extends EObject> clazz) {
		if( selectors.size != 1 ) {
			return null
		}
		val firstSelector = selectors.head
		if( !(firstSelector instanceof SimpleSelectorSequence) ) {
			return null
		}
		val firstSelectorSequence = firstSelector as SimpleSelectorSequence
		if( !(firstSelectorSequence.head == null && firstSelectorSequence.simpleSelectors.size == 1) ) {
			return null
		}
		val simpleSelector = firstSelectorSequence.simpleSelectors.head
		if( !clazz.isAssignableFrom(simpleSelector.^class) ) {
			return null
		}
		// rely on EMF:
		simpleSelector.eGet(simpleSelector.eClass.getEStructuralFeature("name")) as String
	}

	/**
	 * Flattens the members of a rule set to a list,
	 * instead of a maximally-unbalanced tree.
	 */
	def private Iterable<RuleSetMember> members(ExtendedRuleSet ruleSet) {
		val list = new ArrayList<RuleSetMember>();

		var memberWrapper = ruleSet.firstMemberWrapper
		while( memberWrapper != null ) {
			list.add(memberWrapper.member)
			memberWrapper = memberWrapper.next
		}

		list
	}

}

