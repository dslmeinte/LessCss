package nl.dslmeinte.xtext.less.scoping

import com.google.inject.Inject
import nl.dslmeinte.xtext.less.LessLanguageHelper
import nl.dslmeinte.xtext.less.less.LessFile
import org.eclipse.emf.ecore.EReference
import org.eclipse.xtext.scoping.IScope
import org.eclipse.xtext.scoping.Scopes
import org.eclipse.xtext.scoping.impl.AbstractDeclarativeScopeProvider

// TODO  use AbstractDeclarateAnnotationBasedScopeProvider?
class LessScopeProvider extends AbstractDeclarativeScopeProvider {

	@Inject
	extension LessLanguageHelper lessLanguageHelper

	def IScope scope_MixinCall_group(LessFile lessFile, EReference ref) {
		Scopes::scopeFor(lessFile.namespaceCandidates, [ it | it.qNameNamespace ], IScope::NULLSCOPE)
	}

	def IScope scope_MixinCall_ruleSet(LessFile lessFile, EReference ref) {
		Scopes::scopeFor(lessFile.mixinCandidates, [ it | it.qNameMixin ], IScope::NULLSCOPE)
	}

}
