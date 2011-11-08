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
		it.ruleSets.filter(rs|rs.canBeMixin)
	}

	def /* private */ canBeMixin(ExtendedRuleSet it) {
		it.atomicClassName != null
	}

	def namespaceCandidates(LessFile it) {
		it.ruleSets.filter(rs|rs.canBeNamespace)
	}

	def /* private */ canBeNamespace(ExtendedRuleSet it) {
		it.atomicID != null
	}

	def /* private */ ruleSets(LessFile it) {
		it.statements.filter(typeof(ExtendedRuleSet))
	}

	@Inject
	extension IQualifiedNameConverter qNameConverter

	def qNameMixin(ExtendedRuleSet it) {
		if( it.atomicClassName == null ) {
			throw new IllegalArgumentException("can only compute q-name for rule set that can act as mixin")
		}
		it.atomicClassName.toQualifiedName
	}

	def qNameNamespace(ExtendedRuleSet it) {
		if( it.atomicID == null ) {
			throw new IllegalArgumentException("can only compute q-name for rule set that can act as namespace")
		}
		it.atomicID.toQualifiedName
	}

	def /* private */ atomicClassName(ExtendedRuleSet it) {
		it.atomicSelector(typeof(ClassSelector))
	}

	def /* private */ atomicID(ExtendedRuleSet it) {
		it.atomicSelector(typeof(IDSelector))
	}

	def /* private */ atomicSelector(ExtendedRuleSet it, Class<? extends EObject> clazz) {
		if( it.selectors.size != 1 ) {
			return null
		}
		val firstSelector = it.selectors.head
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
	def /* private */ Iterable<RuleSetMember> members(ExtendedRuleSet ruleSet) {
		val list = new ArrayList<RuleSetMember>();

		var memberWrapper = ruleSet.firstMemberWrapper
		while( memberWrapper != null ) {
			list.add(memberWrapper.member)
			memberWrapper = memberWrapper.next
		}

		list
	}

}

